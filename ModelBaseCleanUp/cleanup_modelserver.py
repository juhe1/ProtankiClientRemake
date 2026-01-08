import os
import re
import glob

def find_modelserver_files(input_folder):
    """Find all *ModelServer.as files in the input folder, excluding interface files."""
    pattern = os.path.join(input_folder, "**", "*ModelServer.as")
    all_files = glob.glob(pattern, recursive=True)
    # Filter out interface files (files starting with "I" followed by uppercase letter, like IIsisModelServer)
    def is_interface_file(filepath):
        basename = os.path.basename(filepath)
        # Interface files start with "I" followed by another uppercase letter
        return len(basename) >= 2 and basename[0] == 'I' and basename[1].isupper()
    return [f for f in all_files if not is_interface_file(f)]

def clean_imports(content):
    """Remove specified imports."""
    # Imports to remove
    remove_patterns = [
        r'import\s+alternativa\.types\.[^;]+;',
        r'import\s+alternativa\.protocol\.[^;]+;',
        r'import\s+platform\.client\.fp10\.core\.network\.command\.SpaceCommand;',
        r'import\s+platform\.client\.fp10\.core\.model\.impl\.Model;',
        r'import\s+flash\.utils\.ByteArray;',
        r'import\s+platform\.client\.fp10\.core\.type\.ISpace;',
        r'import\s+alternativa\.osgi\.OSGi;',
    ]
    
    lines = content.split('\n')
    new_lines = []
    
    for line in lines:
        should_remove = False
        for pattern in remove_patterns:
            if re.search(pattern, line):
                should_remove = True
                break
        
        if not should_remove:
            new_lines.append(line)
    
    return '\n'.join(new_lines)

def clean_member_variables(content):
    """Remove all member variables except 'private var model:IModel;'."""
    lines = content.split('\n')
    new_lines = []
    
    # Pattern to match member variable declarations
    member_var_pattern = r'^\s*(private|protected|public)\s+var\s+(\w+)\s*:\s*(\w+)'
    
    for line in lines:
        match = re.match(member_var_pattern, line)
        if match:
            var_name = match.group(2)
            # Only keep model variable
            if var_name == 'model':
                new_lines.append(line)
            # Skip all other member variables
        else:
            new_lines.append(line)
    
    return '\n'.join(new_lines)

def clean_constructor(content):
    """Clean constructor to only keep super(); and this.model = param1;"""
    # Find the class name to identify the constructor
    class_match = re.search(r'public\s+class\s+(\w+)', content)
    if not class_match:
        return content
    
    class_name = class_match.group(1)
    
    # Pattern to match the constructor
    # Constructor pattern: public function ClassName(params) { ... }
    constructor_pattern = rf'(public\s+function\s+{re.escape(class_name)}\s*\([^)]*\)\s*\{{)[^}}]*(\}})'
    
    def replace_constructor(match):
        return match.group(1) + '\n         super();\n         this.model = param1;\n      ' + match.group(2)
    
    content = re.sub(constructor_pattern, replace_constructor, content, flags=re.DOTALL)
    
    return content

def empty_method_bodies(content):
    """Empty all method bodies except the constructor."""
    # Find the class name to skip the constructor
    class_match = re.search(r'public\s+class\s+(\w+)', content)
    class_name = class_match.group(1) if class_match else None
    
    lines = content.split('\n')
    new_lines = []
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Check if this is a method declaration (public/private/protected function)
        method_match = re.match(r'^(\s*)(public|private|protected)\s+function\s+(\w+)\s*\([^)]*\)\s*:\s*\w+\s*$', line)
        
        if method_match:
            indent = method_match.group(1)
            method_name = method_match.group(3)
            
            # Skip constructor (already handled)
            if method_name == class_name:
                new_lines.append(line)
                i += 1
                continue
            
            # This is a regular method, add the signature
            new_lines.append(line)
            i += 1
            
            # Find the opening brace
            while i < len(lines) and '{' not in lines[i]:
                new_lines.append(lines[i])
                i += 1
            
            if i < len(lines):
                # Add opening brace line
                new_lines.append(lines[i])
                i += 1
                
                # Skip everything until we find the matching closing brace
                brace_count = 1
                while i < len(lines) and brace_count > 0:
                    brace_count += lines[i].count('{') - lines[i].count('}')
                    if brace_count == 0:
                        # This is the closing brace, add it
                        new_lines.append(lines[i])
                    i += 1
        else:
            # Check for method with opening brace on the same line
            method_with_brace = re.match(r'^(\s*)(public|private|protected)\s+function\s+(\w+)\s*\([^)]*\)\s*:\s*\w+\s*\{', line)
            
            if method_with_brace:
                indent = method_with_brace.group(1)
                method_name = method_with_brace.group(3)
                
                # Skip constructor
                if method_name == class_name:
                    new_lines.append(line)
                    i += 1
                    continue
                
                # Add the line with opening brace
                new_lines.append(line)
                i += 1
                
                # Skip until closing brace
                brace_count = 1
                while i < len(lines) and brace_count > 0:
                    brace_count += lines[i].count('{') - lines[i].count('}')
                    if brace_count == 0:
                        new_lines.append(lines[i])
                    i += 1
            else:
                new_lines.append(line)
                i += 1
    
    return '\n'.join(new_lines)

def remove_empty_lines_excessive(content):
    """Remove excessive empty lines (more than 1 consecutive)."""
    lines = content.split('\n')
    new_lines = []
    prev_empty = False
    
    for line in lines:
        is_empty = line.strip() == ''
        
        if is_empty:
            if not prev_empty:
                new_lines.append('')  # Keep one empty line
            prev_empty = True
        else:
            new_lines.append(line)
            prev_empty = False
    
    return '\n'.join(new_lines)

def process_modelserver_file(filepath):
    """Process a single ModelServer file."""
    print(f"Processing: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Apply all transformations
    content = clean_imports(content)
    content = clean_member_variables(content)
    content = clean_constructor(content)
    content = empty_method_bodies(content)
    content = remove_empty_lines_excessive(content)
    
    return content

def main():
    # Get the script's directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_folder = os.path.join(script_dir, "input_code")
    output_folder = os.path.join(script_dir, "output_code")
    
    # Check if input folder exists
    if not os.path.exists(input_folder):
        print(f"Error: Input folder not found: {input_folder}")
        print("Please create an 'input_code' folder and place your ModelServer.as files there.")
        return
    
    # Create output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)
    
    # Find all ModelServer files
    modelserver_files = find_modelserver_files(input_folder)
    
    if not modelserver_files:
        print(f"No *ModelServer.as files found in {input_folder}")
        return
    
    print(f"Found {len(modelserver_files)} ModelServer file(s)")
    
    for filepath in modelserver_files:
        # Process the file
        cleaned_content = process_modelserver_file(filepath)
        
        # Calculate relative path from input folder
        rel_path = os.path.relpath(filepath, input_folder)
        
        # Create output path
        output_path = os.path.join(output_folder, rel_path)
        
        # Create output directory if needed
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        
        # Write the cleaned content
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(cleaned_content)
        
        print(f"  -> Saved to: {output_path}")
    
    print(f"\nDone! Processed {len(modelserver_files)} file(s)")

if __name__ == "__main__":
    main()

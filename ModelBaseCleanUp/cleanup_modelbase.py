import os
import re
import glob

def find_modelbase_files(input_folder):
    """Find all *ModelBase.as files in the input folder."""
    pattern = os.path.join(input_folder, "**", "*ModelBase.as")
    return glob.glob(pattern, recursive=True)

def clean_imports(content):
    """Remove all imports except the allowed ones."""
    # Allowed imports patterns
    allowed_patterns = [
        r'import\s+alternativa\.types\.Long;',
        r'import\s+platform\.client\.fp10\.core\.model\.IModel;',
        r'import\s+platform\.client\.fp10\.core\.model\.impl\.Model;',
        r'import\s+[\w.]+CC;',  # imports ending with CC;
    ]
    
    # Find all import lines
    import_pattern = r'^\s*import\s+[^;]+;\s*$'
    
    def should_keep_import(import_line):
        for pattern in allowed_patterns:
            if re.search(pattern, import_line):
                return True
        return False
    
    lines = content.split('\n')
    new_lines = []
    
    for line in lines:
        if re.match(import_pattern, line):
            if should_keep_import(line):
                new_lines.append(line)
            # Skip non-allowed imports
        else:
            new_lines.append(line)
    
    return '\n'.join(new_lines)

def clean_member_variables(content):
    """Remove all member variables except modelId and server."""
    # Pattern for member variable declarations (private var, protected var, etc.)
    # We want to keep:
    # - private var modelId:Long = Long.getLong(...);
    # - protected var server:*ModelServer;
    
    lines = content.split('\n')
    new_lines = []
    
    # Pattern to match member variable declarations
    member_var_pattern = r'^\s*(private|protected|public)\s+var\s+(\w+)\s*:\s*(\w+)'
    
    for line in lines:
        match = re.match(member_var_pattern, line)
        if match:
            var_name = match.group(2)
            var_type = match.group(3)
            
            # Keep modelId and server variables
            if var_name == 'modelId' or var_name == 'server':
                new_lines.append(line)
            # Skip all other member variables
        else:
            new_lines.append(line)
    
    return '\n'.join(new_lines)

def clean_initcodecs_method(content):
    """Clean initCodecs method to only keep the server initialization line."""
    # Find the initCodecs method and extract only the server line
    
    # Pattern to match the server initialization line
    server_init_pattern = r'this\.server\s*=\s*new\s+\w+ModelServer\s*\(\s*IModel\s*\(\s*this\s*\)\s*\)\s*;'
    
    # Find the server initialization line in the content
    server_match = re.search(server_init_pattern, content)
    server_line = server_match.group(0) if server_match else None
    
    # Pattern to match the entire initCodecs method
    # This handles methods with braces and content inside
    initcodecs_pattern = r'(protected\s+function\s+initCodecs\s*\(\s*\)\s*:\s*void\s*\{)[^}]*(\})'
    
    if server_line:
        # Replace the initCodecs method content with just the server line
        def replace_initcodecs(match):
            return match.group(1) + '\n         ' + server_line + '\n      ' + match.group(2)
        
        content = re.sub(initcodecs_pattern, replace_initcodecs, content, flags=re.DOTALL)
    
    return content

def remove_invoke_method(content):
    """Remove the invoke method completely."""
    # Pattern to match the invoke method with its full body including nested braces
    # We need to handle nested switch/case statements
    
    lines = content.split('\n')
    new_lines = []
    in_invoke = False
    brace_count = 0
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Check if this is the start of invoke method
        if re.search(r'override\s+public\s+function\s+invoke\s*\(', line):
            in_invoke = True
            brace_count = 0
            # Count braces on this line
            brace_count += line.count('{') - line.count('}')
            i += 1
            continue
        
        if in_invoke:
            brace_count += line.count('{') - line.count('}')
            if brace_count <= 0:
                in_invoke = False
            i += 1
            continue
        
        new_lines.append(line)
        i += 1
    
    return '\n'.join(new_lines)

def fix_id_getter(content):
    """Change 'return this.modelId;' to 'return modelId;' in the id getter."""
    # Pattern to match the id getter and fix the return statement
    pattern = r'return\s+this\.modelId\s*;'
    replacement = 'return modelId;'
    return re.sub(pattern, replacement, content)

def change_modelid_to_static_const(content):
    """Change 'private var modelId:Long' to 'private static const modelId:Long'."""
    pattern = r'private\s+var\s+modelId\s*:\s*Long'
    replacement = 'private static const modelId:Long'
    return re.sub(pattern, replacement, content)

def remove_empty_lines_excessive(content):
    """Remove excessive empty lines (more than 2 consecutive)."""
    # Replace 3 or more consecutive newlines with 2 newlines
    return re.sub(r'\n{3,}', '\n\n', content)

def process_modelbase_file(filepath):
    """Process a single ModelBase file."""
    print(f"Processing: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Apply all transformations
    content = clean_imports(content)
    content = clean_member_variables(content)
    content = clean_initcodecs_method(content)
    content = remove_invoke_method(content)
    content = fix_id_getter(content)
    content = change_modelid_to_static_const(content)
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
        print("Please create an 'input_code' folder and place your ModelBase.as files there.")
        return
    
    # Create output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)
    
    # Find all ModelBase files
    modelbase_files = find_modelbase_files(input_folder)
    
    if not modelbase_files:
        print(f"No *ModelBase.as files found in {input_folder}")
        return
    
    print(f"Found {len(modelbase_files)} ModelBase file(s)")
    
    for filepath in modelbase_files:
        # Process the file
        cleaned_content = process_modelbase_file(filepath)
        
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
    
    print(f"\nDone! Processed {len(modelbase_files)} file(s)")

if __name__ == "__main__":
    main()

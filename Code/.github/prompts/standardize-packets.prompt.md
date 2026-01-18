---
name: standardize-packets
description: Standardize packet handlers and packet classes by replacing hardcoded IDs with static id constants and renaming classes to InPacket/OutPacket.
argument-hint: "Provide a handler file or folder to process (e.g., src/scpacker/networking/protocol/packets/externalentrance)"
agent: agent
---

Goal
Ensure packet handlers and packet classes are consistent, readable, and maintainable by:
- Replacing hardcoded numeric IDs with `<PacketClass>.id` static constants
- Renaming packet classes/files to end with `InPacket` or `OutPacket`

Scope
- Primarily under `scpacker/networking/protocol/packets/**` and their handler classes.
- Keep runtime behavior intact. Do not change `getPacketHandlerId()` values.

Instructions
1) Identify handler cases
- In the target handler(s), locate `switch(param1.getId())` and list all `case` IDs.
- Example to process: `${input:targetPath:Path to handler or folder}` (defaults to current selection `${selection}`).

2) Find packet classes for each ID
- Search for `override public function getId()` returning each number.
- Confirm the packet belongs to the handler via `getPacketHandlerId()`.

3) Rename packet classes and files
- Choose descriptive names ending with `InPacket` (incoming/server→client) or `OutPacket` (outgoing/client→server).
- Use PascalCase (e.g., `LoadExternalEntranceInPacket`, `ValidationFailedInPacket`, `CreateLinkForExistingUserOutPacket`).

4) Add static id constant in each packet
- Add `public static const id:int = <existing numeric id>;`
- Update:
  - `override public function getId():int { return id; }`
  - `override public function initializeSelf():AbstractPacket { return new <RenamedClass>(); }`

5) Make sure that packet properties are camelCase
- Rename properties from `PascalCase` to `camelCase` (e.g., `SocialNetworkEntranceParams` → `socialNetworkEntranceParams`).

6) Update handler switch to use constants
- Replace `case <number>:` with `case <PacketClass>.id:`
- Cast `param1` to the renamed packet class when passing to helper methods.

7) Imports and unused code
- Update imports to match new names.
- Remove unused imports.

8) Register packet handler and all the packets in PacketInitializer.as

Example (ExternalEntrance)
- IDs mapping:
  - `LoadExternalEntranceInPacket.id` replaces `-1715719586`
  - `ValidationFailedInPacket.id` replaces `-570114058`
  - `ValidationSuccessInPacket.id` replaces `-1179390022`

Notes
- Avoid modifying unrelated logic.
- Prefer minimal, surgical changes.

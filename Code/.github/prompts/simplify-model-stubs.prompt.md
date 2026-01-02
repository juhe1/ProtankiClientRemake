name: simplify-model-stubs
description: Strip generated model base/server pairs down to static model id and empty calls while keeping constructor wiring and required init helpers.
argument-hint: "Provide target files or folder (e.g., src/projects/tanks/**/model/**)"
agent: agent
---

Goal
Reduce model base/server classes to minimal shells: keep model id/static wiring and constructor assignment; remove protocol/codec/network logic and handler switch scaffolding.

Scope
- Model base classes (e.g., `*ModelBase`)
- Model server stubs (e.g., `*ModelServer`)

Instructions
1) Model base
- Keep constructor and server initialization (e.g., `this.server = new SomeModelServer(IModel(this));`).
- Make `modelId` a `public static` field; return it from `get id()`.
- Remove protocol, client callback fields, and invoke switch handlers that map packet IDs to client methods.
- If the model base contains a `getInitParam` helper, **do not remove it**. Example:
  - ```
    protected function getInitParam() : BattleParamInfoCC
    {
       return BattleParamInfoCC(initParams[Model.object]);
    }
    ```
- Drop any unused imports after pruning.

2) Server stub
- Keep constructor and the `this.model = param1;` assignment.
- Empty method bodies (e.g., `fight`, `joinAsSpectator`) but **preserve signatures and parameter types**.
- Remove protocol/codec/buffer/command logic and related fields.
- Drop unused imports.

3) Cleanup
- Ensure remaining imports are minimal.
- Preserve class/package structure and visibility.

Notes
- Keep behavior changes minimal: we are intentionally stubbing out network logic while keeping type signatures and IDs intact.
- Avoid touching unrelated classes or logic outside the targeted files.

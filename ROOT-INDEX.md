# Vault Index

Sacred sources index for the RevLoop operating system. The write gate reads this file to enforce required reads before any deliverable is written.

## Required Sources

These files MUST be read before any deliverable or content is written. The write gate enforces this mechanically.

- 60-Context/positioning.md
- 60-Context/icp.md
- 60-Context/brand-voice.md

## Context Files (load as needed)

Additional context that supplements required sources. Located in `60-Context/`.

## Entity Folders (context.md required per entity)

Writing to any file inside an entity folder requires reading that entity's `context.md` first.

## Session State

Session state lives in `.session/` and is ephemeral (auto-cleared on Stop). Never reference session files in deliverables.

Persona overlays specialize this template for different operator types. When you set `persona` in USER.md, follow the matching overlay file's activation steps to create folders, promote skills, and tune preferences.

# Persona Overlays

Each persona file describes how the template specializes for that operator type. When you set `persona: <name>` in USER.md, read the matching `_personas/<name>.md` and follow its activation steps.

## How activation works (manual today, automated later)

1. Set `persona: <name>` in USER.md.
2. Read `_personas/<name>.md`.
3. Execute the steps it lists: create directories, promote `_available/` skills into `.claude/skills/`, set USER.md preferences, ignore (don't promote) the listed defaults.
4. A future `/select-persona` skill will do this automatically.

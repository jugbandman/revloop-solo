# Export Deliverable

Clean a markdown document for delivery. Strip internal formatting, remove wiki-links and frontmatter, and produce a polished export-ready file.

## Prerequisites

- Read the source file before processing
- Read `60-Context/brand-voice.md` to verify voice compliance

## Workflow

### 1. Identify the Source

Ask the user:
- Which file should be exported? (Path in the repo)
- What format? (Clean markdown, plain text, or structured for copy-paste into Google Docs/email)
- Who is the recipient? (For file naming)

### 2. Clean the Markdown

Apply these transformations:

**Remove frontmatter:**
- Strip any YAML frontmatter (between `---` markers at the top)

**Remove wiki-links:**
- Convert `[[Target|Display Text]]` to just `Display Text`
- Convert `[[Target]]` to just `Target`

**Remove internal references:**
- Strip any lines that reference internal file paths
- Remove any `TODO`, `FIXME`, or internal annotation markers
- Remove any comments or notes marked as internal

**Clean formatting:**
- Ensure consistent heading levels
- Remove any empty sections
- Fix any orphaned bullet points
- Normalize whitespace

**Verify voice compliance:**
- Check for em-dashes and replace with commas or restructured sentences
- Check for any NEVER-list violations from voice rules (see USER.md or CLIENT.md)
- Ensure the configured sign-off on any correspondence
- Flag anything that sounds robotic or generic

### 3. Add Polish

- Ensure the document has a clear title
- Add date if not present
- Verify all placeholders (e.g., `{add value}`) are either filled or flagged to the user
- Check that any referenced attachments or links are valid

### 4. Save the Export

Save to deliverables folder with `YYYY-MM-DD-{type}-{description}.md` naming convention.

Present a diff summary showing what was changed:
- Number of wiki-links converted
- Frontmatter removed (yes/no)
- Voice violations fixed
- Any items flagged for user review

### 5. Prepare for Delivery

Suggest delivery method:
- If email: offer to draft a cover email in the founder's voice
- If document: note that the markdown can be pasted into Google Docs or converted with pandoc
- If proposal: verify all investment figures are correct before sending

## Voice Rules

- The exported document must pass the voice check
- No em-dashes, no SDR phrases, no generic filler
- Configured sign-off on any correspondence
- Investment language (never cost/pricing)

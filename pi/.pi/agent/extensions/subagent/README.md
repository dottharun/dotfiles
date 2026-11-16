# Pi Subagent

Observable, persistent Pi subagents for independent reviews, investigations, and delegated implementation.

Each subagent runs in its own tmux session with a dedicated Pi JSONL session. The parent can inspect status, wait for durable results, steer active work, queue follow-ups, or attach directly to the child TUI.

## Requirements

- Pi
- Node.js 22.19 or newer
- tmux

## Install

Clone into Pi's global extension directory and expose the CLI on `PATH`:

```sh
git clone git@github.com:earendil-works/pi-subagent.git ~/.pi/agent/extensions/subagent
ln -s ../extensions/subagent/subagent.ts ~/.pi/agent/bin/subagent
```

Run `/reload` in an existing Pi session. The extension contributes its bundled skill automatically.

## Usage

Spawn with a descriptive name using the parent session's provider, model, and thinking level:

```sh
subagent spawn --name review --prompt "Review the current diff independently"
```

Names appear in the parent UI. Generated handles remain the stable identifiers used by management commands.

Override the model configuration when needed:

```sh
subagent spawn \
  --provider openai-codex \
  --model gpt-5.4-mini \
  --thinking low \
  --prompt "Find the relevant implementation"
```

Provide multiple prompt fragments and files:

```sh
subagent spawn \
  --file /tmp/spec.md \
  --prompt "Implement this specification" \
  --prompt "Run the targeted tests"
```

Restrict tools for a read-only investigation:

```sh
subagent spawn --tools read,grep,find,ls --prompt "Investigate the failure"
```

Manage a run by its generated handle:

```sh
subagent status a1b2c3
subagent rename a1b2c3 "error handling review"
subagent send a1b2c3 "Focus on error handling"
subagent send a1b2c3 --follow-up "Then summarize"
subagent wait a1b2c3
subagent stop a1b2c3
subagent list
```

Use `/subagent` to select and attach to an active child. The status widget shows active names (or handles for unnamed runs) and their current state.

## Isolation

Optional spawn flags:

- `--tools <names>`: comma-separated tool allowlist
- `--no-extensions`: disable extension discovery while retaining the control bridge
- `--no-skills`: disable skills
- `--no-prompt-templates`: disable prompt templates
- `--no-context-files`: ignore repository instruction files

## Nesting depth (owner setting)

`shared.ts` `MAX_SUBAGENT_DEPTH` is the only knob. Depth 0 is the main session, 1 a top-level subagent, 2 a nested subagent. Spawn is allowed while current depth < max. Default `2`: children can spawn grandchildren, grandchildren cannot spawn further. Set `1` to restore the old no-nesting behavior. There is deliberately no CLI flag, env override, or skill option for this; agents that try `PI_SUBAGENT_DEPTH=0 subagent spawn` still fail because the parent depth is read from its metadata file.

Child sessions receive the subagent skill only while they are still allowed to nest deeper. Children survive `/reload`. When a session quits or is replaced, its whole tree is suspended deepest-first: processes stop, but transcripts and metadata are kept. Resuming relaunches direct children, which in turn relaunch theirs. `subagent stop` removes a run and its descendants permanently.

# Agent task prompts

Use PROJECT-WORK.md as the project's work index. Replace the task ID below with
an existing ready record. These prompts describe a workflow and grant no extra
permission to publish, install, access secrets or work outside the task scope.

## Select work

Read PROJECT-WORK.md and its linked current requirements, constraints and latest
handoff. Reconcile the highest-priority ready task with actual code, tests and
recent commits. Name its requirement, product outcome, scope, prerequisites and
acceptance commands before editing. Resume unfinished work first. If the ready
queue is empty, report the specific planning decision needed. Preserve historical
roadmap context and distinguish implemented work from remaining work.

## Execute TASK-ID

Implement only TASK-ID from PROJECT-WORK.md. Reproduce its defect or establish
the unmet requirement. Preserve unrelated owner changes and existing meaningful
assertions. Run the specified acceptance commands against the final source.
Record actual exit statuses and evidence. Commit the owned repair after required
validation. Perform publication only when authorized and verify its destination
and revision. A placeholder printing success cannot validate product behavior.

## Resume TASK-ID

Read TASK-ID's last attempt and exact failure before exploring. Reconcile current
diffs and commits. Run the next recorded experiment using the project's actual
toolchain and shell. Update the failure and next action if blocked. Retry a
known prerequisite failure only after its relevant condition changed or when a
new experiment can distinguish a concrete hypothesis.

## Close TASK-ID

Compare the final diff, retained assertions and actual acceptance results with
the task's product outcome. Check that required commands passed on the final
revision and that required publication was verified. Failed or skipped required
checks keep the task incomplete. Record the resulting revision, evidence and
remaining work in PROJECT-WORK.md. Existing successful work does not constitute
a new deliverable. Select another ready task only after closure is supported.

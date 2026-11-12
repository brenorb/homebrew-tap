------------------------------- MODULE ReleaseGate -------------------------------

CONSTANT RejectEditedFormula
VARIABLE gate

Init ==
    \E input \in {"none", "other formula", "fast-transcript"}:
        gate = [phase |-> "brew check", input |-> input, edited |-> FALSE]

CheckBrew ==
    /\ gate.phase = "brew check"
    /\ \E brewAvailable \in BOOLEAN:
        gate' = [gate EXCEPT !.phase = IF ~brewAvailable THEN "fail"
                                      ELSE IF gate.input = "none" THEN "pass" ELSE "style"]

StyleFailed ==
    /\ gate.phase = "style"
    /\ gate' = [gate EXCEPT !.phase = "fail"]

StyleCompleted ==
    /\ gate.phase = "style"
    /\ \E edited \in BOOLEAN:
        gate' = [gate EXCEPT !.edited = edited, !.phase = "compare hashes"]

CompareHashes ==
    /\ gate.phase = "compare hashes"
    /\ gate' = [gate EXCEPT !.phase =
        IF gate.edited /\ RejectEditedFormula THEN "fail"
        ELSE IF gate.input = "fast-transcript" THEN "python check" ELSE "pass"]

CheckPython ==
    /\ gate.phase = "python check"
    /\ \E pythonAvailable \in BOOLEAN:
        gate' = [gate EXCEPT !.phase = IF pythonAvailable THEN "formula version" ELSE "fail"]

ReadFormulaVersion ==
    /\ gate.phase = "formula version"
    /\ \E agrees \in BOOLEAN:
        gate' = [gate EXCEPT !.phase = IF agrees THEN "PyPI version" ELSE "fail"]

ReadPypiVersion ==
    /\ gate.phase = "PyPI version"
    /\ \E agrees \in BOOLEAN:
        gate' = [gate EXCEPT !.phase = IF agrees THEN "GitHub assets" ELSE "fail"]

ReadGithubAssets ==
    /\ gate.phase = "GitHub assets"
    /\ \E available \in BOOLEAN:
        gate' = [gate EXCEPT !.phase = IF available THEN "pass" ELSE "fail"]

Done ==
    /\ gate.phase \in {"pass", "fail"}
    /\ UNCHANGED gate

Next == CheckBrew \/ StyleFailed \/ StyleCompleted \/ CompareHashes \/ CheckPython
        \/ ReadFormulaVersion \/ ReadPypiVersion \/ ReadGithubAssets \/ Done

StyleChangesRequireRestaging == gate.phase = "pass" => ~gate.edited

=============================================================================

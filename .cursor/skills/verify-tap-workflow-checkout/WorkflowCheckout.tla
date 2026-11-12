---------------------------- MODULE WorkflowCheckout ----------------------------
EXTENDS Naturals

CONSTANT MaxJobs
VARIABLE scan

Init ==
    scan = [job |-> 0, localScript |-> FALSE, container |-> FALSE, checkout |-> FALSE,
            earlyScript |-> FALSE, failure |-> FALSE, result |-> "scanning"]

ScanningJob == scan.result = "scanning" /\ scan.job > 0
RejectJob == scan.localScript /\ (scan.container \/ ~scan.checkout)

BeginJob ==
    /\ scan.result = "scanning" /\ scan.job < MaxJobs
    /\ scan' = [scan EXCEPT !.job = @ + 1, !.localScript = FALSE,
                          !.container = FALSE, !.checkout = FALSE,
                          !.failure = (@ \/ RejectJob)]

ReadCheckout ==
    /\ ScanningJob /\ ~scan.checkout
    /\ scan' = [scan EXCEPT !.checkout = TRUE]

ReadContainer ==
    /\ ScanningJob /\ ~scan.container
    /\ scan' = [scan EXCEPT !.container = TRUE]

ReadLocalScript ==
    /\ ScanningJob /\ ~scan.localScript
    /\ scan' = [scan EXCEPT !.localScript = TRUE, !.earlyScript = (@ \/ ~scan.checkout)]

EndFile ==
    /\ scan.result = "scanning"
    /\ scan' = [scan EXCEPT !.result = IF scan.failure \/ RejectJob THEN "fail" ELSE "pass"]

Done ==
    /\ scan.result # "scanning"
    /\ UNCHANGED scan

Next == BeginJob \/ ReadCheckout \/ ReadContainer \/ ReadLocalScript \/ EndFile \/ Done

ApprovedScriptsFollowCheckout == scan.result = "pass" => ~scan.earlyScript

=============================================================================

CREATE TABLE PM_BASELINES_APPROVE_STATUS
(
  BASELINE_ID  NUMBER(19),
  APPROVED CHAR(1),
  UNIQUE(BASELINE_ID)
)
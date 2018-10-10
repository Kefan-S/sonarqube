CREATE TABLE "CE_ACTIVITY" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_TYPE" VARCHAR(15) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NULL,
  "TMP_COMPONENT_UUID" VARCHAR(40) NULL,
  "TMP_MAIN_COMPONENT_UUID" VARCHAR(40) NULL,
  "ANALYSIS_UUID" VARCHAR(50) NULL,
  "STATUS" VARCHAR(15) NOT NULL,
  "IS_LAST" BOOLEAN NOT NULL,
  "IS_LAST_KEY" VARCHAR(55) NOT NULL,
  "SUBMITTER_UUID" VARCHAR(255) NULL,
  "WORKER_UUID" VARCHAR(40) NULL,
  "EXECUTION_COUNT" INTEGER NOT NULL,
  "SUBMITTED_AT" BIGINT NOT NULL,
  "STARTED_AT" BIGINT NULL,
  "EXECUTED_AT" BIGINT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  "EXECUTION_TIME_MS" BIGINT NULL,
  "ERROR_MESSAGE" VARCHAR(1000),
  "ERROR_STACKTRACE" CLOB,
  "ERROR_TYPE" VARCHAR(20)
);
CREATE UNIQUE INDEX "CE_ACTIVITY_UUID" ON "CE_ACTIVITY" ("UUID");
CREATE INDEX "CE_ACTIVITY_COMPONENT_UUID" ON "CE_ACTIVITY" ("COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_TMP_CMPT_UUID" ON "CE_ACTIVITY" ("TMP_COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_TMP_MAIN_CMPT_UUID" ON "CE_ACTIVITY" ("TMP_MAIN_COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_ISLASTKEY" ON "CE_ACTIVITY" ("IS_LAST_KEY");
CREATE INDEX "CE_ACTIVITY_ISLAST_STATUS" ON "CE_ACTIVITY" ("IS_LAST", "STATUS");

CREATE TABLE "CE_TASK_CHARACTERISTICS" (
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_UUID" VARCHAR(40) NOT NULL,
  "KEE" VARCHAR(50) NOT NULL,
  "TEXT_VALUE" VARCHAR(4000),

  CONSTRAINT "PK_CE_TASK_CHARACTERISTICS" PRIMARY KEY ("UUID")
);
CREATE INDEX "CE_TASK_CHARACTERISTICS_TASK_UUID" ON "CE_TASK_CHARACTERISTICS" ("TASK_UUID");

CREATE TABLE "PROJECTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
  "KEE" VARCHAR(400),
  "UUID" VARCHAR(50) NOT NULL,
  "UUID_PATH" VARCHAR(1500) NOT NULL,
  "ROOT_UUID" VARCHAR(50) NOT NULL,
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "MODULE_UUID" VARCHAR(50),
  "MODULE_UUID_PATH" VARCHAR(1500),
  "MAIN_BRANCH_PROJECT_UUID" VARCHAR(50),
  "NAME" VARCHAR(2000),
  "DESCRIPTION" VARCHAR(2000),
  "PRIVATE" BOOLEAN NOT NULL,
  "TAGS" VARCHAR(500),
  "ENABLED" BOOLEAN NOT NULL DEFAULT TRUE,
  "SCOPE" VARCHAR(3),
  "QUALIFIER" VARCHAR(10),
  "DEPRECATED_KEE" VARCHAR(400),
  "PATH" VARCHAR(2000),
  "LANGUAGE" VARCHAR(20),
  "COPY_COMPONENT_UUID" VARCHAR(50),
  "LONG_NAME" VARCHAR(2000),
  "DEVELOPER_UUID" VARCHAR(50),
  "CREATED_AT" TIMESTAMP,
  "AUTHORIZATION_UPDATED_AT" BIGINT,
  "B_CHANGED" BOOLEAN,
  "B_COPY_COMPONENT_UUID" VARCHAR(50),
  "B_DESCRIPTION" VARCHAR(2000),
  "B_ENABLED" BOOLEAN,
  "B_UUID_PATH" VARCHAR(1500),
  "B_LANGUAGE" VARCHAR(20),
  "B_LONG_NAME" VARCHAR(500),
  "B_MODULE_UUID" VARCHAR(50),
  "B_MODULE_UUID_PATH" VARCHAR(1500),
  "B_NAME" VARCHAR(500),
  "B_PATH" VARCHAR(2000),
  "B_QUALIFIER" VARCHAR(10)
);
CREATE INDEX "PROJECTS_ORGANIZATION" ON "PROJECTS" ("ORGANIZATION_UUID");
CREATE UNIQUE INDEX "PROJECTS_KEE" ON "PROJECTS" ("KEE");
CREATE INDEX "PROJECTS_ROOT_UUID" ON "PROJECTS" ("ROOT_UUID");
CREATE UNIQUE INDEX "PROJECTS_UUID" ON "PROJECTS" ("UUID");
CREATE INDEX "PROJECTS_PROJECT_UUID" ON "PROJECTS" ("PROJECT_UUID");
CREATE INDEX "PROJECTS_MODULE_UUID" ON "PROJECTS" ("MODULE_UUID");
CREATE INDEX "PROJECTS_QUALIFIER" ON "PROJECTS" ("QUALIFIER");
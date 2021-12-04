inThisBuild(
  Seq(
    version := "0.1.0-SNAPSHOT",
    scalaVersion := "2.12.15",
    semanticdbEnabled := true, // enable SemanticDB
    semanticdbVersion := scalafixSemanticdb.revision // only required for Scala 2.x
  )
)

lazy val root = (project in file("."))
  .settings(
    resolvers += "aws-glue-etl-artifacts" at "https://aws-glue-etl-artifacts.s3.amazonaws.com/release/",
    name := "glue-app",
    libraryDependencies ++= Seq(
      "com.amazonaws" % "AWSGlueETL" % "3.0.0",
      "org.apache.spark" %% "spark-core" % "3.1.1" % "provided" withSources () withJavadoc (),
      "org.apache.spark" %% "spark-sql" % "3.1.1" % "provided" withSources () withJavadoc ()
    ),
    dependencyOverrides ++= Seq(
      "com.fasterxml.jackson.core" % "jackson-core" % "2.13.0",
      "com.fasterxml.jackson.core" % "jackson-databind" % "2.13.0",
      "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.13.0"
    ),
    scalacOptions ++= Seq(
      "-Ywarn-adapted-args",
      "-Ywarn-unused-import",
      "-deprecation"
    )
  )
  .enablePlugins(PackPlugin)

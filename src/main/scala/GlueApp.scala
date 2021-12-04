import com.amazonaws.services.glue.GlueContext
import com.amazonaws.services.glue.util.GlueArgParser
import com.amazonaws.services.glue.util.Job
import com.amazonaws.services.glue.util.JsonOptions
import org.apache.spark.SparkContext
import scala.collection.JavaConverters._

object GlueApp {
  def main(sysArgs: Array[String]): Unit = {
    val spark: SparkContext = new SparkContext()
    val glueContext: GlueContext = new GlueContext(spark)
    // @params: [JOB_NAME]
    val args =
      GlueArgParser.getResolvedOptions(sysArgs, Seq("JOB_NAME").toArray)
    Job.init(args("JOB_NAME"), glueContext, args.asJava)

    val dataInDf = glueContext
      .getSourceWithFormat(
        connectionType = "file",
        format = "json",
        options = JsonOptions(
          Map(
            "paths" -> List("data/in/"),
            "recurse" -> true
          )
        )
      )
      .getDynamicFrame()

    val dataOutDf = glueContext
      .getSinkWithFormat(
        connectionType = "file",
        format = "json",
        options = JsonOptions(
          Map(
            "path" -> "data/out/",
            "partitionKeys" -> List("a")
          )
        )
      )
      .writeDynamicFrame(dataInDf)

    Job.commit()
  }
}

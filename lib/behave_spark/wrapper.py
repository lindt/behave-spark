from functools import wraps


def create_spark_context():
    from pyspark.sql import SparkSession

    return SparkSession.builder.appName('behave-spark').getOrCreate()


def create_hive_context(spark_context):
    from pyspark.sql import HiveContext

    return HiveContext(spark_context)


def spark(func):
    @wraps(func)
    def wrapper(*args, **kwds):
        context = args[0]
        if 'spark' not in context:
            context.spark = create_spark_context()

        return func(*args, **kwds)
    return wrapper


def hive(func):
    @wraps(func)
    def wrapper(*args, **kwds):
        context = args[0]
        if 'spark' not in context:  # TODO: use spark wrapper
            context.spark = create_spark_context()
        if 'hive' not in context:
            context.hive = create_hive_context(context.spark)

        return func(*args, **kwds)
    return wrapper

# TODO: sc.stop()

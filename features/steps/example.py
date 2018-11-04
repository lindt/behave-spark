from behave import given, then, when
from behave_spark.parser import to_dataframe
from behave_spark.wrapper import hive, spark


@given('a flight of a rocket with an')
@given('a falcon X rocket with an inertial measurement unit')
@when('it flew 10 times for each 10 hours')
@then('the inertial measurement unit has a total of 100 operating hours')
@hive
def create_rocket(_):
    pass  # TODO


@given('a table')
@given('a gherkin table as input')
@spark
def create_table(context):
    context.data = to_dataframe(context.table)


@given('another table')
def create_another_table(context):
    context.data2 = to_dataframe(context.table)


@then('it equals')
def assert_equals(context):
    from nose.tools import eq_

    expected = to_dataframe(context.table)

    eq_(expected.keys().tolist(), context.data.keys().tolist())
    eq_(expected.values, context.data.values)


@then('it not equals')
def assert_not_equals(context):
    from nose.tools import assert_not_equal

    expected = to_dataframe(context.table)

    assert_not_equal(
        expected.keys().tolist() + expected.values,
        context.data.keys().tolist() + context.data.values,
    )

from pyspark.sql import *

import sys, getopt

MONTH = 2
ORIGIN_CITY_NAME = 15
DEST_CITY_NAME = 24
DEP_DELAY = 32
CANCELLED = 47

# We list all the fields in the input data file for your reference root
# year: integer (nullable = true)   // index 0
# quarter: integer (nullable = true)
# month: integer (nullable = true)
# dayofmonth: integer (nullable = true)
# dayofweek: integer (nullable = true)
# flightdate: string (nullable = true)
# uniquecarrier: string (nullable = true)
# airlineid: integer (nullable = true)
# carrier: string (nullable = true)
# tailnum: string (nullable = true)
# flightnum: integer (nullable = true)
# originairportid: integer (nullable = true)
# originairportseqid: integer (nullable = true)
# origincitymarketid: integer (nullable = true)
# origin: string (nullable = true)   // airport short name
# origincityname: string (nullable = true) // e.g., Seattle, WA
# originstate: string (nullable = true)
# originstatefips: integer (nullable = true)
# originstatename: string (nullable = true)
# originwac: integer (nullable = true)
# destairportid: integer (nullable = true)
# destairportseqid: integer (nullable = true)
# destcitymarketid: integer (nullable = true)
# dest: string (nullable = true)
# destcityname: string (nullable = true)
# deststate: string (nullable = true)
# deststatefips: integer (nullable = true)
# deststatename: string (nullable = true)
# destwac: integer (nullable = true)
# crsdeptime: integer (nullable = true)
# deptime: integer (nullable = true)
# depdelay: integer (nullable = true)
# depdelayminutes: integer (nullable = true)
# depdel15: integer (nullable = true)
# departuredelaygroups: integer (nullable = true)
# deptimeblk: integer (nullable = true)
# taxiout: integer (nullable = true)
# wheelsoff: integer (nullable = true)
# wheelson: integer (nullable = true)
# taxiin: integer (nullable = true)
# crsarrtime: integer (nullable = true)
# arrtime: integer (nullable = true)
# arrdelay: integer (nullable = true)
# arrdelayminutes: integer (nullable = true)
# arrdel15: integer (nullable = true)
# arrivaldelaygroups: integer (nullable = true)
# arrtimeblk: string (nullable = true)
# cancelled: integer (nullable = true)
# cancellationcode: integer (nullable = true)
# diverted: integer (nullable = true)
# crselapsedtime: integer (nullable = true)
# actualelapsedtime: integer (nullable = true)
# airtime: integer (nullable = true)
# flights: integer (nullable = true)
# distance: integer (nullable = true)
# distancegroup: integer (nullable = true)
# carrierdelay: integer (nullable = true)
# weatherdelay: integer (nullable = true)
# nasdelay: integer (nullable = true)
# securitydelay: integer (nullable = true)
# lateaircraftdelay: integer (nullable = true)
# firstdeptime: integer (nullable = true)
# totaladdgtime: integer (nullable = true)
# longestaddgtime: integer (nullable = true)
# divairportlandings: integer (nullable = true)
# divreacheddest: integer (nullable = true)
# divactualelapsedtime: integer (nullable = true)
# divarrdelay: integer (nullable = true)
# divdistance: integer (nullable = true)
# div1airport: integer (nullable = true)
# div1airportid: integer (nullable = true)
# div1airportseqid: integer (nullable = true)
# div1wheelson: integer (nullable = true)
# div1totalgtime: integer (nullable = true)
# div1longestgtime: integer (nullable = true)
# div1wheelsoff: integer (nullable = true)
# div1tailnum: integer (nullable = true)
# div2airport: integer (nullable = true)
# div2airportid: integer (nullable = true)
# div2airportseqid: integer (nullable = true)
# div2wheelson: integer (nullable = true)
# div2totalgtime: integer (nullable = true)
# div2longestgtime: integer (nullable = true)
# div2wheelsoff: integer (nullable = true)
# div2tailnum: integer (nullable = true)
# div3airport: integer (nullable = true)
# div3airportid: integer (nullable = true)
# div3airportseqid: integer (nullable = true)
# div3wheelson: integer (nullable = true)
# div3totalgtime: integer (nullable = true)
# div3longestgtime: integer (nullable = true)
# div3wheelsoff: integer (nullable = true)
# div3tailnum: integer (nullable = true)
# div4airport: integer (nullable = true)
# div4airportid: integer (nullable = true)
# div4airportseqid: integer (nullable = true)
# div4wheelson: integer (nullable = true)
# div4totalgtime: integer (nullable = true)
# div4longestgtime: integer (nullable = true)
# div4wheelsoff: integer (nullable = true)
# div4tailnum: integer (nullable = true)
# div5airport: integer (nullable = true)
# div5airportid: integer (nullable = true)
# div5airportseqid: integer (nullable = true)
# div5wheelson: integer (nullable = true)
# div5totalgtime: integer (nullable = true)
# div5longestgtime: integer (nullable = true)
# div5wheelsoff: integer (nullable = true)
# div5tailnum: integer (nullable = true)


def main(argv):
    # Take a data file location and output file destination as inputs
    dataFile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["ifile=", "ofile="])
    except getopt.GetoptError:
        print('Usage: sparkapp.py -i <inputfile> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('test.py -i <inputfile> -o <outputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            dataFile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg

    # ************************************************************
    # IMPORTANT - Change this comment before running on a cluster:
    spark = createLocalSession()
    # spark = createClusterSession()
    # ************************************************************

    spark.sparkContext.setLogLevel("ERROR")

    r = warmup(spark, dataFile)
    r.repartition(1).write.mode("overwrite").format("csv").save(outputfile + "_warmup.txt")

    rA = QA(spark, dataFile)
    rA.repartition(1).write.mode("overwrite").format("text").save(outputfile + "QA")

    rB = QB(spark, dataFile)
    rB.repartition(1).write.mode("overwrite").format("csv").save(outputfile + "QB")

    rC = QC(spark, dataFile)
    rC.repartition(1).write.mode("overwrite").format("csv").save(outputfile + "QC")


# Create a SparkSession for running code locally
def createLocalSession():
    return SparkSession.builder.appName("SparkApp").config("spark.master", "local").getOrCreate()


# Create a SparkSession for running code on a cluster
def createClusterSession():
    return SparkSession.builder.appName("SparkApp").getOrCreate()


# A set of completed examples for you to look at and test on EMR
def warmup(spark, dataFile):
    d = spark.read.parquet(dataFile)
    rdd = d.rdd

    d.createOrReplaceTempView("flights")
    r1 = spark.sql("SELECT DISTINCT destcityname FROM flights ORDER BY destcityname")

    r2 = d.select(d.colRegex("destcityname")).distinct().orderBy(d.colRegex("destcityname"))

    r3 = rdd.map(lambda t: Row(t[DEST_CITY_NAME])).distinct().sortBy(lambda t: t[0], True, 1)
    r3 = spark.createDataFrame(r3)

    return r1


# Select all flights that leave from 'Seattle, WA', and return the destination
# city names. Only return each destination city name once. Return the results
# in a RDD where the Row is a single column for the destination city name.
#
# Use the Spark functional APIs or SparkSQL.
#
# (5 points, 50 rows from local data, 79 rows from full data)
def QA(spark, dataFile):
    d = spark.read.parquet(dataFile)
    rdd = d.rdd

    # d.createOrReplaceTempView("flights")
    # r1 = spark.sql("SELECT DISTINCT destcityname FROM flights WHERE origincityname = "
    #                "'Seattle, WA' GROUP BY destcityname")
    r1 = rdd.filter(lambda t: t[ORIGIN_CITY_NAME] == 'Seattle, WA') \
            .map(lambda t: Row(t[DEST_CITY_NAME])) \
            .distinct() \
            .sortBy(lambda t: t[0], True, 1)
    r1 = spark.createDataFrame(r1)
    # TODO: your code here
    return r1


# Find the number of non-cancelled (!= 1) flights per month-origin city pair,
# return the results in an RDD where the Row has three columns that are the
# origin city name, month, and count, in that order.
#
# Only use the Spark functional APIs
#
# (10 points, 281 rows from local data, 4383 rows from full data)
def QB(spark, dataFile):
    d = spark.read.parquet(dataFile)
    r1 = d.where(d.colRegex("cancelled") != 1)\
            .groupBy(d.colRegex("origincityname"),d.colRegex("month")).count()
    # r1 = spark.createDataFrame(r)
    # TODO: your code here
    return r1


# Compute the average delay from all departing flights for each city. Flights
# with NULL delay values should not be counted. Return the results in an RDD
# where the Row has two columns that are the origin city name and average, in
# that order.
#
# Only use the Spark functional APIs
#
# (10 points, 281 rows from local data, 383 rows from full data)
def QC(spark, dataFile):
    d = spark.read.parquet(dataFile)
    r1 = d.filter(d.colRegex("depdelay").isNotNull()) \
            .groupBy(d.colRegex("origincityname")) \
            .avg("depdelay")

    # TODO: your code here
    return r1


if __name__ == "__main__":
    main(sys.argv[1:])

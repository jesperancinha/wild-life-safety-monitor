# wild-life-safety-monitor

This repo is meant to be used as a standard repo to understand how Kuma works and how it can be used with an example of
a real world scenario.

## Diagram

```mermaid

```

## Services Description

#### Listener Service

Receives data from sensors and uses an streaming service that receives the data.
This service needs to be able to be very responsive and not consume a lot of resources (reactive)

#### Collector Service

The collector service receives all data from the listener via HTTP and stores it in the database
It needs to do this reliable with multiple checks. It does this asynchronously and rejects requests. It logs the
results.

#### Aggregator Service

This service is responsible to make calculations.
It loops through the database for events and will start asynchronous processes to make calculations and store them in the database.

#### Management Service

The management service deals with the identity of animals and their realtime information
For simplicity, and for this demo, the only CRUD functions it provides is to alter data from the animals and their associated sensors.

#### Graphic User Interface Service.

The GUI will allow realtime view of sensor and calculated data.
It will also allow the editing and change of identifiable animal data.

## About me

[![GitHub followers](https://img.shields.io/github/followers/jesperancinha.svg?label=Jesperancinha&style=for-the-badge&logo=github&color=grey "GitHub")](https://github.com/jesperancinha)

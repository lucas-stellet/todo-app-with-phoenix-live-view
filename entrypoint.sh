#!/bin/bash

echo "waiting for postgres..."

sleep 18

bin/todo eval "Todo.Release.migrate"

bin/todo start
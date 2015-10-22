#!/bin/bash

OUTPUT_DIR="$1"

BASEDIR=$(dirname $0)
echo $BASEDIR

echo $BASEDIR
echo $OUTPUT_DIR

$BASEDIR/nova_list_to_csv.rb --output-directory=$OUTPUT_DIR
$BASEDIR/nova_volumes_to_csv.rb --output-directory=$OUTPUT_DIR
$BASEDIR/extract_vm_details.rb --output-directory=$OUTPUT_DIR

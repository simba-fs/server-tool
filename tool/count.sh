#!/bin/bash
declare -A cnt
while read id extre
do
	let cnt[$id]++
done
for id in "${!cnt[@]}"
do
	echo $id ${cnt[$id]}
done

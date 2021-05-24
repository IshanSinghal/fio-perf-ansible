#!/bin/bash

rm -f /{root,tmp}/fio_benchmark_* >/dev/null 2>&1

i=0
while [ "$i" -lt 5 ]; do
  mkdir -p /root/fiotest
  fio --name=write_throughput --directory=/root/fiotest \
      --numjobs=8 --size=1G \
      --time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
      --verify=0 --bs=1M --iodepth=64 \
      --rw=write --group_reporting=1 > /tmp/fio_benchmark_write_throughput_round_"$i"_"$(date -u --iso-8601=ns)".log 2>> fio_write_throughput_error.log
  rm -rf /root/fiotest
  i=$((i+1))
done


i=0
while [ "$i" -lt 5 ]; do
  mkdir -p /root/fiotest
  fio --name=read_throughput --directory=/root/fiotest \
      --numjobs=8 --size=1G \
      --time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
      --verify=0 --bs=1M --iodepth=64 \
      --rw=read --group_reporting=1 > /tmp/fio_benchmark_read_throughput_round_"$i"_"$(date -u --iso-8601=ns)".log 2>> fio_read_throughput_error.log
  rm -rf /root/fiotest
  i=$((i+1))
done


i=0
while [ "$i" -lt 5 ]; do
  mkdir -p /root/fiotest
  fio --name=write_iops --directory=/root/fiotest \
      --numjobs=3 --size=10G \
      --time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
      --verify=0 --bs=4K --iodepth=64 \
      --rw=randwrite --group_reporting=1 > /tmp/fio_benchmark_write_iops_round_"$i"_"$(date -u --iso-8601=ns)".log 2>> fio_write_iops_error.log
  rm -rf /root/fiotest
  i=$((i+1))
done


i=0
while [ "$i" -lt 5 ]; do
  mkdir -p /root/fiotest
  fio --name=read_iops --directory=/root/fiotest \
      --numjobs=3 --size=10G \
      --time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
      --verify=0 --bs=4K --iodepth=64 \
      --rw=randread --group_reporting=1 > /tmp/fio_benchmark_read_iops_round_"$i"_"$(date -u --iso-8601=ns)".log 2>> fio_read_iops_error.log
  rm -rf /root/fiotest
  i=$((i+1))
done



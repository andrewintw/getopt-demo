
```
$ ./getopt_test.sh 
HitCount:  5
ScanRange: 500
LogType:   ALL
```

```
$ ./getopt_test.sh -c 123
HitCount:  123
ScanRange: 500
LogType:   ALL
```

```
$ ./getopt_test.sh --range 456
HitCount:  5
ScanRange: 456
LogType:   ALL
```

```
$ ./getopt_test.sh --range 456 --log
HitCount:  5
ScanRange: 456
LogType:   ALL
```

```
$ ./getopt_test.sh --range 456 --log=chl
HitCount:  5
ScanRange: 456
LogType:   chl
```

```
$ ./getopt_test.sh --range 456 --log=chl -c 5566
HitCount:  5566
ScanRange: 456
LogType:   chl
```

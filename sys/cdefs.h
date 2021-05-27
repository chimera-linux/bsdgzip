#ifndef CDEFS_H
#define CDEFS_H

#define __FBSDID(x)

#define __printflike(a, b)
#define __dead2

/* other compat bits */

#define nitems(x) (sizeof((x)) / sizeof((x)[0]))

#define	DEFFILEMODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH)

extern char *__progname;

#define getprogname() __progname

#endif

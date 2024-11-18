R# ICCAT `base` `public` library

A set of general-purpose functions meant for public usage.

Currently only includes [logging facilities](#logging_facilities) which allow outputting (to screen) messages with different levels of severity.

## Logging facilities <a name="logging_facilities"></a>

There are four distinct log severity levels, and namely:

+ `DEBUG`
+ `INFO`
+ `WARN`
+ `ERROR`

in **ascending** severity order.

Logging is currently done on the **standard error** channel, with log messages having the following structure:

```R
[ yyyy/MM/dd HH:mm:ss ] : [ < severity > ] : { < prefix (when provided) > } : < message >
```

> Only log messages of a severity level **equal to** or **higher than** the current log level set for the session will be effectively emitted.

## External dependencies (CRAN) <a name="external_deps"></a>
None

## Internal dependencies <a name="internal_deps"></a>
None

# Installing the library from GitHub

1) Ensure that all dependencies (both [external](#external_deps) and [internal](#internal_deps)) are installed
2) Ensure that the `devtools` package is installed, if not, execute the following:
```R
install.packages("devtools")
```
3) Once `devtools` is available, execute the following:
```R
library(devtools)

install_github("stats-ICCAT/iccat.pub.base", dependencies = FALSE)
```

# Building the library

Assuming that all [external](#external_deps) and [internal](#internal_deps) dependencies are already installed in the R environment, and that the `devtools` package and [RTools](https://cran.r-project.org/bin/windows/Rtools/) are both available, the building process can be either started within R studio by selecting the Build > Build Source Package menu entry:

![image](https://github.com/user-attachments/assets/f209d8d4-568c-4200-bcf2-fb1fa0e1d2ef)

or by executing the following statement:

```R
devtools::document(roclets = c('rd', 'collate', 'namespace'))
```

# Examples

## Loading the library

For the examples to work, the following statement should be executed once per session:

```R
library(iccat.pub.base)
```
## Generic logging function

The generic logging function (`log_`) can be invoked by providing: a **severity level**, a **message**, and an *optional* **prefix**, e.g.:

```R
log_(severity = LOG_INFO, text = "Log message") # No prefix specified
```

that will emit:

```R
[ 2024-11-05 11:35:56 ] : [ INFO ] : Log message
```

if the current log level is `INFO` or above, or

```R
log_(severity = LOG_INFO, text = "Log message", prefix = "Prefix") # To specify a custom prefix
```

that will emit:

```R
[ 2024-11-05 11:35:56 ] : [ INFO ] : { Prefix } : Log message
```

## Changing log severity level for the current R session

```R
set_log_level(LOG_WARN) # To set 'warning' as minimum severity level for messages to appear on the log
```

will return:

```R
Log level: WARN
```

## Showing the current R session log severity level

```R
get_log_level()
```

will return:

```R
[1] "INFO"
```

> *Shorthand functions* exist (`DEBUG`, `INFO`, `WARN`, `ERROR`) that do *implicitly* assign a severity level and therefore only expect a message and an optional prefix to work, e.g.:

```R
INFO(text = "Log message")
```

or the actual logging level set for the session.

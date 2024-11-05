# ICCAT base public library

A set of general-purpose functions meant for public usage.

Currently only includes logging facilities which allow outputting (to screen) messages with different levels of severity.

## External dependencies (CRAN)
None

## Internal dependencies
None

# Usage

## Logging facilities

There are four distinct log severity levels, and namely:

+ `DEBUG`
+ `INFO`
+ `WARN`
+ `ERROR`

in **ascending** severity order.

The current severity level for a session can be set using the `set_log_level` function by providing the label corresponding to the chosen level. E.g.:

```
set_log_level(LOG_WARN) # To set 'warning' as minimum severity level for messages to appear on the log
```

will return:

```
Log level: WARN
```

Accordingly, the severity level for the current session can be read using the `get_log_level` function. E.g.

```
get_log_level()
```

will return:

```
[1] "INFO"
```

or the actual logging level set for the session.

Logging is currently done on the **standard error** channel, with log messages having the following structure:

```
[ yyyy/MM/dd HH:mm:ss ] : [ < severity > ] : { < prefix (when provided) > } : < message >
```

**Only log messages of a severity level equal to or higher than the current log level set for the session will be effectively emitted**.

The generic logging function (`log_`) can be invoked by providing: a **severity level**, a **message**, and an *optional* **prefix**, e.g.:

```
log_(severity = LOG_INFO, text = "Log message") # No prefix specified
```

that will emit:

```
[ 2024-11-05 11:35:56 ] : [ INFO ] : Log message
```

if the current log level is `INFO` or above, or

```
log_(severity = LOG_INFO, text = "Log message", prefix = "Prefix") # To specify a custom prefix
```

that will emit:

```
[ 2024-11-05 11:35:56 ] : [ INFO ] : { Prefix } : Log message
```

*Shorthand functions* exist (`DEBUG`, `INFO`, `WARN`, `ERROR`) that do *implicitly* assign a severity level and therefore only expect a message and an optional prefix to work, e.g.:

```
INFO(text = "Log message")
```


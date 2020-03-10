# fluent-plugin-bunyan

[Fluentd](https://fluentd.org/) parser plugin to process logs from applications that write [bunyan](https://github.com/gildas/go-logger/blob/master/trentm/node-bunyan) logs.

The plugin requires [Fluentd](https://fluentd.org/) 1.0 at least.

## Installation

Pretty straight forward:  
```console
$ gem install fluent-plugin-bunyan
```

## Configuration

Simply add the parser to the [Fluentd](https://fluentd.org/) configuration file, for example:

```xml
<source>
  @type tail # say the logs come from stdout
  <parse>
    @type bunyan
  </parse>
</source>
```

## Testing

To run the unit tests, make sure you have the [Fluentd](https://fluentd.org/) gem installed and run:

```console
bundle exec rake test
```

## Copyright

* Copyright(c) 2020- Gildas Cherruel
* License
  * MIT

# fluent-plugin-bunyan

[Fluentd](https://fluentd.org/) parser plugin to process logs from applications that write [bunyan](https://github.com/gildas/go-logger/blob/master/trentm/node-bunyan) logs.

The plugin requires [Fluentd](https://fluentd.org/) 1.0 at least.

|  |   |
---|---|
master | [![Build Status](https://dev.azure.com/keltiek/gildas/_apis/build/status/gildas.fluent-plugin-bunyan?branchName=master)](https://dev.azure.com/keltiek/gildas/_build/latest?definitionId=4&branchName=master)
dev | [![Build Status](https://dev.azure.com/keltiek/gildas/_apis/build/status/gildas.fluent-plugin-bunyan?branchName=dev)](https://dev.azure.com/keltiek/gildas/_build/latest?definitionId=4&branchName=dev)

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
rake test
```

## Copyright

* Copyright(c) 2020- Gildas Cherruel
* License
  * MIT

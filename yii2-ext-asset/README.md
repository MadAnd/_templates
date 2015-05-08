# {bower-name} asset for Yii2
Provides the asset bundle for easy integration of [{bower-name}]({asset-url}) into your Yii2 application.


## Installation

The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

Either run

```bash
composer require --prefer-dist "madand/{ext-key}:*"
```

or add

```
"madand/{ext-key}": "*"
```

to the `require` section of your `composer.json` file.


## Usage

In the view file register the asset:

```php
\madand\{namespace}\{ClassName}Asset::register($this);
```


## License

The BSD License (BSD). Please see [License File](LICENSE.md) for more information.

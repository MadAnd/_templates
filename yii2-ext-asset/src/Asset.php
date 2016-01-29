<?php
/**
 * @link https://github.com/MadAnd/{ext-key}
 * @copyright Copyright (c) 2016 Andriy Kmit' <dev@madand.net>
 * @license http://opensource.org/licenses/BSD-3-Clause
 */

namespace madand\{namespace};

use yii\web\AssetBundle;

class {ClassName}Asset extends AssetBundle
{
    public $sourcePath = '@vendor/bower/{bower-name}';
    public $css = [
        '{bower-name}.css',
    ];
    public $js = [
        '{bower-name}.js',
    ];
    public $depends = [
        'yii\web\JqueryAsset',
    ];
}

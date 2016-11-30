# 2. Drawing in 2D

This entry provides an introduction to Kha's 2D graphics API. The samples cover how to:

* set up the rendering context;
* draw shapes;
* work with transformations.

## 2.1. API design

```haxe
var g2 = framebuffer.g2;
g2.begin();
// ...
g2.end();
```

clear, flush

## 2.2. Drawing shapes

`g2.drawLine()`
`g2.drawRect()`
`g2.fillRect()`
`g2.fillTriangle()`

> **What about circles, polygons, and other shapes?**
>
> See `kha.graphics2.GraphicsExtension`.

## 2.3. The transformation stack

transformation
translate()
rotate()
push/pop

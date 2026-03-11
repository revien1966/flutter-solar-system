onScaleUpdate(details) {

  camera.zoom *= details.scale;

  camera.position -= details.focalPointDelta / camera.zoom;

}
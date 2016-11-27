let project = new Project('Khatalogue - 01e');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
project.targetOptions.html5 = {
	canvasId: 'khatalogue-01e',
	scriptName: 'khatalogue-01e'
};
resolve(project);

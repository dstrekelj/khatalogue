let project = new Project('Khatalogue - 01c');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
project.targetOptions.html5 = {
	canvasId: 'khatalogue-01c',
	scriptName: 'khatalogue-01c'
};
resolve(project);

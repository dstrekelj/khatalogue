let project = new Project('Khatalogue - 01c');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
resolve(project);

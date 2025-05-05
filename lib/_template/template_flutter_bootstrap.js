{{flutter_js}}
{{flutter_build_config}}

// set constraint
const container = document.createElement('div');
container.style.display = 'flex';
container.style.justifyContent = 'center';
container.style.alignItems = 'center';
container.style.height = '100vh';

// set loading element
const loading = document.createElement('div');
loading.style.width = "100px";
loading.style.height = "100px";
lottie.loadAnimation({
    container: loading,
    renderer: 'svg',
    loop: true,
    autoplay: true,
    path: '../assets/lottie/loading.json'
});

container.appendChild(loading);
document.body.appendChild(container);
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  }
});
/**
 * http://usejsdoc.org/
 */

console.log("k8s-nodejs")

const k8s = require('@kubernetes/client-node');
const request = require('request');

const kc = new k8s.KubeConfig();
kc.loadFromDefault();


const k8sApi = kc.makeApiClient(k8s.CoreV1Api);

k8sApi.listNode().then((res) => {
	res.body.items.forEach((node) => { console.log("node ->", node.metadata.name) })
})

k8sApi.listNamespacedPod('default').then((res) => {

	res.body.items.forEach((pod, index) => { console.log("pod --> ", index, pod.metadata.name) });
});

k8sApi.readNamespacedPod("nginx", "default").then((res) => {

	console.log("readNamespacedPod --> ", res.body.metadata.name);
});


const opts = {};
kc.applyToRequest(opts);

request.get(`${kc.getCurrentCluster().server}/api/v1/namespaces/default/pods`, opts,
	(error, response, body) => {
		if (error) {
			console.log(`error: ${error}`);
		}
		if (response) {
			console.log(`statusCode: ${response.statusCode}`);
		}
		//console.log(`body: ${body}`);
		JSON.parse(body).items.forEach((pod, index) => { console.log(`${kc.getCurrentCluster().server}/api/v1/namespaces/default/pods --> `, index, pod.metadata.name) })
	});


const exec = new k8s.Exec(kc);

const commad = ["sh", "-c", "echo exec =========; date; hostname; echo exec ========= "];

exec.exec('default', 'nginx', 'nginx', commad,
	process.stdout, process.stderr, process.stdin,
	true /* tty */,
	(status) => {
		// tslint:disable-next-line:no-console
		console.log('Exited with status:');
		// tslint:disable-next-line:no-console
		console.log(JSON.stringify(status, null, 2));
		process.exit();
	});



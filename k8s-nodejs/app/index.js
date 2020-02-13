/**
 * http://usejsdoc.org/
 */

console.log("k8s-nodejs")

const k8s = require('@kubernetes/client-node');
const request = require('request');

const kc = new k8s.KubeConfig();
kc.loadFromDefault();


const k8sApi = kc.makeApiClient(k8s.CoreV1Api);

k8sApi.listNamespacedPod('default').then((res) => {
	// console.log(res.body)
	console.log(res.body.items.forEach(function (pod, index) { console.log("1 --> ", index, pod.metadata.name) }));
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
		JSON.parse(body).items.forEach(function (pod, index) { console.log("2 --> ", index, pod.metadata.name) })
	});
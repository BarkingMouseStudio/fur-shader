using UnityEngine;
using System.Collections;

public class FurBehaviour : MonoBehaviour {

	public Material furMaterial;
	public int layerCount = 20;

	MeshFilter meshFilter;

	void Start() {
		meshFilter = GetComponent<MeshFilter>();
	}

	void Update() {
		var m = Matrix4x4.identity;
		m.SetTRS(transform.position, transform.rotation, transform.localScale);

		for (int i = 0; i < layerCount; i++) {
			furMaterial.SetFloat("_LayerIndex", (float)i / (float)layerCount);
			Graphics.DrawMesh(meshFilter.mesh, m, furMaterial, 1);
		}
	}
}

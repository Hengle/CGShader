using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class Main : MonoBehaviour {

	public GameObject projectorObject;
	public Camera projCamera;

	private Projector projector;
	private float near=0.3f;
	private float far=50f;
	private float aspect=1f;
	private float fov=1f;
	private float d;

	public Matrix4x4 world2ProjView;
	public Matrix4x4 projM;
	public Matrix4x4 correction;
	public Matrix4x4 cm;
	//public Transform projector;
	// Use this for initialization
	void Start () {

		correction = Matrix4x4.identity;
		correction.SetColumn(3,new Vector4(0.5f,0.5f,0.5f,1f));
		correction.m00 = 0.5f;
		correction.m11 = 0.5f;
		correction.m22 = 0.5f;
	}
	
	// Update is called once per frame
	void Update () {
		world2ProjView = projector.transform.worldToLocalMatrix;

		projCamera.aspect = 1;
		cm = correction * projCamera.projectionMatrix * projCamera.worldToCameraMatrix;
		Shader.SetGlobalMatrix("projectM", cm);
	}
}

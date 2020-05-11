using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Far_near : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        //object controlling far near clip plane
        Shader.SetGlobalFloat("_Near", transform.position.x);
        Shader.SetGlobalFloat("_Far", transform.position.y);

    }
}

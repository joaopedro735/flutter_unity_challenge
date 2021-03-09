using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CurrentTime : MonoBehaviour
{
    private TextMeshProUGUI textComponent;
    private static readonly string dateFormat = "dd-MM-yyyy HH:mm:ss";
    // Start is called before the first frame update
    void Start()
    {
        textComponent = GetComponent<TextMeshProUGUI>();
        Debug.Log(textComponent.text);
        StartCoroutine(UpdateDateTimeRoutine());
    }

    // Update is called once per frame
    void Update()
    {
    }

    IEnumerator UpdateDateTimeRoutine()
    {
        while (true)
        {
            yield return new WaitForSeconds(1);
            textComponent.text = GetCurrentDateTimeFormatted();
        }
    }

    private String GetCurrentDateTimeFormatted()
    {
        return DateTime.Now.ToString(dateFormat);
    }
}

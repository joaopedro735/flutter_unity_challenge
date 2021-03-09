using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;


public class Manager : MonoBehaviour
{
    public GameObject sun;
    public GameObject clouds;
    public TextMeshProUGUI temperatureText;
    public GameObject rainPrefab;
    private bool alreadySpawnedRain = false;
    private int rainToSpawn = 50;

    // Start is called before the first frame update
    void Start()
    {
        //string json = @"{""temperature"":9,""weatherCondition"":""Clouds""}";
        //Debug.Log(json);

        //var text = Weather.ParseJson(json);
        //temperatureText.text = text.GetTemperatureWithUnit();
        //Debug.Log(text.temperature + " " + text.weatherCondition + " " + text.WeatherConditionToEnum());
        // SpawnRain(30);
    }


    // Update is called once per frame
    void Update()
    {
    }

    private void SpawnRain(int rainToSpawn)
    {
        alreadySpawnedRain = true;
        for (int i = 0; i < rainToSpawn; i++)
        {
            Instantiate(rainPrefab, GenerateRainSpawnPosition(), rainPrefab.transform.rotation);
        }
    }

    private Vector3 GenerateRainSpawnPosition()
    {
        float spawnPosX = Random.Range(-4.45f, 5);
        float spawnPosY = Random.Range(-5, 0.7f);
        float spawnPosZ = Random.Range(5, 9);
        Vector3 randomPos = new Vector3(spawnPosX, spawnPosY, spawnPosZ);
        return randomPos;
    }

    public void SetActiveElement(string data)
    {
        FlutterUnityPlugin.Message message = FlutterUnityPlugin.Messages.Receive(data);

        Weather weather = Weather.ParseJson(message.data);

        temperatureText.text = weather.GetTemperatureWithUnit();

        switch (weather.WeatherConditionToEnum())
        {
            case WeatherCondition.Clouds:
                sun.SetActive(true);
                clouds.SetActive(true);
                DestroyRain();
                break;
            case WeatherCondition.Rain:
                sun.SetActive(false);
                clouds.SetActive(true);
                if (!alreadySpawnedRain) SpawnRain(rainToSpawn);
                break;
            default:
                sun.SetActive(true);
                clouds.SetActive(false);
                DestroyRain();
                break;
        }
    }

    private void DestroyRain()
    {
        if (alreadySpawnedRain)
        {
            var rainObjects = GameObject.FindGameObjectsWithTag("Rain");
            foreach (var rainObj in rainObjects)
            {
                Destroy(rainObj);
            }
            alreadySpawnedRain = false;
        }
    }

}
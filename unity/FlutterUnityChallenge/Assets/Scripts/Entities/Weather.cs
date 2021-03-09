using System;
using UnityEngine;

enum WeatherCondition {
    Thunderstorm,
    Drizzle,
    Rain,
    Snow,
    Atmosphere,
    Clear,
    Clouds
};

class Weather
{

    public int temperature;

    public string weatherCondition;

    public WeatherCondition WeatherConditionToEnum()
    {
        return (WeatherCondition)Enum.Parse(typeof(WeatherCondition), weatherCondition, true);
    }
    public string GetTemperatureWithUnit()
    {
        return string.Format("{0}º C", temperature);
    }

    public static Weather ParseJson(string json)
    {
        return JsonUtility.FromJson<Weather>(json);
    }
}
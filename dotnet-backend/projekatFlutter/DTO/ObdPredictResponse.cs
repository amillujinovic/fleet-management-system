using System.Text.Json.Serialization;

namespace projekatFlutter.DTO
{
    public class ObdPredictResponse
    {
        [JsonPropertyName("anomaly_score")]
        public double AnomalyScore { get; set; }

        [JsonPropertyName("is_anomaly")]
        public bool IsAnomaly { get; set; }
    }
}
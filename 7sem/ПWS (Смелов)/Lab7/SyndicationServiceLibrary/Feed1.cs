using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Syndication;
using System.ServiceModel.Web;
using System.Text;
using System.Xml;
using Newtonsoft.Json;

namespace SyndicationServiceLibrary
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени класса "Feed1" в коде и файле конфигурации.
    public class Feed1 : IFeed1
    {
        public SyndicationFeedFormatter CreateFeed()
        {
            SyndicationFeed feed = new SyndicationFeed("Subjects & Notes", "Get list of notes by all subjects for this student", null);
            List<SyndicationItem> items = new List<SyndicationItem>();
            string url = "http://localhost:9898/Service1.svc/note?$select=subject,note1&$format=json";

            try
            {
                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";

                using (var response = (HttpWebResponse)request.GetResponse())
                using (var reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    string responseString = reader.ReadToEnd();
                    var notesResponse = JsonConvert.DeserializeObject<NoteResponse>(responseString);
                    foreach (var note in notesResponse.Value)
                    {
                        string title = $"Предмет: {note.Subj}";
                        string content = $"Оценка: {note.Note1}";
                        items.Add(new SyndicationItem(title, content, null));
                    }
                }
            }
            catch (Exception ex)
            {
                items.Add(new SyndicationItem("Error", $"Failed to retrieve grades: {ex.Message}", null));
            }
            feed.Items = items;
            string query = WebOperationContext.Current.IncomingRequest.UriTemplateMatch.QueryParameters["format"];
            if (query == "atom")
            {
                return new Atom10FeedFormatter(feed);
            }
            else
            {
                return new Rss20FeedFormatter(feed);
            }
        }


        public SyndicationFeedFormatter GetStudentNotes(string studentId, string formatRequest)
        {
            var feed = new SyndicationFeed("Subjects & Notes", "Get list of notes by all subjects for this student", null);
            var items = new List<SyndicationItem>();

            var url =
                $"http://localhost:9898/Service1.svc/note?$filter=stud_id eq {studentId}&$select=subject,note1";
            if (formatRequest == "json")
            {
                url += "&$format=json";
            }

            var request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Method = "GET";

            using (var response = (HttpWebResponse)request.GetResponse())
            using (var reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                var responseString = reader.ReadToEnd();

                if (formatRequest == "json")
                {
                    var notesResp = JsonConvert.DeserializeObject<NoteResponse>(responseString);
                    var notes = notesResp.Value;
                    foreach (var note in notes)
                    {
                        items.Add(new SyndicationItem(note.Subj, note.Note1.ToString(), null));
                    }
                }
                else if (formatRequest == "atom")
                {
                    var xmlReader = XmlReader.Create(new StringReader(responseString));
                    var atomFeed = SyndicationFeed.Load(xmlReader);

                    items.AddRange(atomFeed.Items);
                }
            }

            feed.Items = items;

            var query = WebOperationContext.Current.IncomingRequest.UriTemplateMatch.QueryParameters["format"];
            SyndicationFeedFormatter formatter = null;
            if (query == "atom")
            {
                formatter = new Atom10FeedFormatter(feed);
            }
            else
            {
                formatter = new Rss20FeedFormatter(feed);
            }
            return formatter;
        }
    }
}
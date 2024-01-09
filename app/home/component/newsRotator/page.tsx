import { useEffect, useState } from "react";

interface NewsItem {
  news_id: number;
  content: string;
  // Add other properties as needed
}

const NewsRotator: React.FC = () => {
  const [news, setNews] = useState<NewsItem[]>([]);
  const [currentNewsIndex, setCurrentNewsIndex] = useState(0);

  useEffect(() => {
    const fetchNews = async () => {
      try {
        const response = await fetch("/api/news");
        const data: NewsItem[] = await response.json();
        setNews(data);
      } catch (error) {
        console.error("Error fetching news:", error);
      }
    };

    fetchNews();

    // Rotate news every 5 seconds
    const intervalId = setInterval(() => {
      setCurrentNewsIndex((prevIndex) => (prevIndex + 1) % news.length);
    }, 5000);

    return () => {
      clearInterval(intervalId);
    };
  }, [news]); // Include news in the dependency array

  return (
    <div>
      <div>
        {news.length > 0 && (
          <div key={news[currentNewsIndex].news_id}>
            <p>{news[currentNewsIndex].content}</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default NewsRotator;

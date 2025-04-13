-- Analytics queries verifying all relationships
SELECT 
    b.title AS book_title,
    GROUP_CONCAT(a.author_name) AS authors,
    p.publisher_name,
    COUNT(ol.order_id) AS times_ordered
FROM book b
LEFT JOIN book_author ba ON b.book_id = ba.book_id
LEFT JOIN author a ON ba.author_id = a.author_id
LEFT JOIN publisher p ON b.publisher_id = p.publisher_id
LEFT JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.book_id;
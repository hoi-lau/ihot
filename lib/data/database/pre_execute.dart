const List<String> faireSql = [
  '''
  DROP TABLE IF EXISTS "task_label"
  ''',
  '''
  CREATE TABLE `task_label` (
    `id` int NOT NULL,
    `title` varchar(255) NOT NULL,
    `create_time` int NOT NULL,
    `status` int NOT NULL,
    `update_time` int NOT NULL,
    PRIMARY KEY (`id`)
  );
  ''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`, `status`, `update_time`) VALUES (1, 'To Do', '2022-09-19 15:07:53', 0, '2022-09-20 15:07:05');''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`, `status`, `update_time`) VALUES (2, 'Recently Deleted', '2032-09-20 15:10:53', 0, '2022-09-20 15:10:53');''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`, `status`, `update_time`) VALUES (7, 'Clipboard History', '2022-09-20 15:11:32', 0, '2022-09-21 17:21:32');''',
];

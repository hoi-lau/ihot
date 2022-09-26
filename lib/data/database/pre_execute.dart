const List<String> faireSql = [
  '''
  DROP TABLE IF EXISTS "task_label"
  ''',
  '''
  CREATE TABLE `task_label` (
    `id` int NOT NULL,
    `title` varchar(255) NOT NULL,
    `create_time` int NOT NULL,
    PRIMARY KEY (`id`)
  );
  ''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`) VALUES (7, 'Clipboard History', 1664161298069);''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`) VALUES (1, 'To Do', 1664161298068);''',
  '''INSERT INTO `task_label` (`id`, `title`, `create_time`) VALUES (2, 'Recently Deleted', 1956528000000);''',
  '''
  DROP TABLE IF EXISTS "task"
  ''',
  '''
  CREATE TABLE `task` (
    `id` int NOT NULL,
    `title` varchar(255) NOT NULL,
    `create_time` int NOT NULL,
    `deadline` int NOT NULL,
    `status` varchar(255) NOT NULL,
    `desc` varchar(255) NOT NULL,
    `label` int NOT NULL,
    PRIMARY KEY (`id`)
  )
  ''',
];

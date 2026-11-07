import copy
import unittest

from prepare_import import generate, literal


class ImportTests(unittest.TestCase):
    def setUp(self):
        self.catalog = {'hymnal_id': 'inspiracoes-9-2019', 'source_pages': 160,
                        'hymns': [{'number': 1, 'title': "D'Ele", 'lyrics': 'Linha 1\n\nLinha 2',
                                   'page_start': 3, 'page_end': 4}]}

    def test_stable_import_preserves_reviewed_content(self):
        sql = generate(self.catalog)
        self.assertEqual(sql, generate(copy.deepcopy(self.catalog)))
        self.assertNotIn('do update', sql)
        self.assertNotIn("'published'", sql)
        self.assertIn("D''Ele", sql)
        self.assertIn('Linha 1\n\nLinha 2', sql)

    def test_invalid_ranges_duplicates_and_publication_rejected(self):
        for field, value in [('page_end', 161), ('page_start', 0),
                             ('number', True), ('review_status', 'published')]:
            with self.subTest(field=field):
                invalid = copy.deepcopy(self.catalog)
                invalid['hymns'][0][field] = value
                with self.assertRaises(ValueError):
                    generate(invalid)
        self.catalog['hymns'] *= 2
        with self.assertRaises(ValueError):
            generate(self.catalog)

    def test_quotes_backslashes_and_null_bytes(self):
        self.assertEqual(literal("a\\'; drop table x; --"), "E'a\\\\''; drop table x; --'")
        with self.assertRaises(ValueError):
            literal('a\x00b')


if __name__ == '__main__':
    unittest.main()

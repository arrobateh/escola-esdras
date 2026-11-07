import copy
import json
from pathlib import Path
import unittest

from build_release import build
from segment import segment

SOURCE = Path(__file__).resolve().parents[2] / 'docs/hinarios/inspiracoes-9'


class ReleaseTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.catalog = segment(SOURCE)
        cls.reviewed = json.loads((SOURCE / 'reviewed.json').read_text())

    def test_numbering_and_complete_nonempty_drafts(self):
        rows = self.catalog['hymns']
        self.assertEqual(len(rows), 325)
        self.assertEqual({item['number'] for item in rows}, set(range(1, 330)) - {233, 234, 235, 236})
        self.assertTrue(all(item['lyrics'].strip() and item['review_status'] == 'draft' for item in rows))
        self.assertNotIn('Anotações', rows[-1]['lyrics'])

    def test_displaced_continuations_keep_their_own_lyrics(self):
        rows = {item['number']: item for item in self.catalog['hymns']}
        self.assertEqual([span['page'] for span in rows[139]['source_segments']], [66, 69])
        self.assertEqual([span['page'] for span in rows[138]['source_segments']], [68])
        self.assertEqual([span['page'] for span in rows[134]['source_segments']], [65, 66, 67])
        self.assertNotIn('FINAL DA JORNADA', rows[139]['lyrics'])

    def test_only_reviewed_ten_are_published_and_existing_revisions_preserved(self):
        sql = build(self.catalog, self.reviewed)
        self.assertEqual(sql.count("review_status = 'published' where id ="), 10)
        self.assertEqual(sql.count("and review_status = 'draft';"), 10)
        self.assertEqual(sql.count('insert into public.hymnal_hymns'), 325)
        self.assertEqual(sql.count('begin;'), 1)
        self.assertEqual(sql.count('commit;'), 1)

    def test_unreviewed_or_blank_lyrics_cannot_be_published(self):
        for field, value in [('review_status', 'draft'), ('lyrics', '')]:
            reviewed = copy.deepcopy(self.reviewed)
            reviewed['hymns'][0][field] = value
            with self.assertRaises(ValueError):
                build(self.catalog, reviewed)


if __name__ == '__main__':
    unittest.main()

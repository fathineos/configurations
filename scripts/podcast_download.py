#!/usr/bin/env python3
"""
Download favorite podcasts
"""
import logging
from argparse import ArgumentParser
from datetime import datetime, timedelta
from urllib.request import urlretrieve
from urllib.error import HTTPError


logger = logging.getLogger()
logging.basicConfig(format='%(asctime)-15s %(message)s')
logger.setLevel(logging.INFO)


def main():
    parser = ArgumentParser(description='Download podcasts')
    parser.add_argument('--podcast', help='Podcast to download',
                        choices=['25', 'infowar'], required=True)
    parser.add_argument('--day', help='Show day',
                        choices=['saturday', 'sunday'], required=True)
    parser.add_argument('--download-dir', default='./',
                        help='Download directory to store file')
    args = parser.parse_args()

    if args.podcast == '25':
        radio_show_25(args.day, args.download_dir)
    elif args.podcast == 'infowar':
        infowar()


def radio_show_25(day, output_dir):
    day_offset = {'saturday': 2, 'sunday': 1}
    offset = day_offset.get(day)
    if not offset:
        raise Exception('invalid day')

    now = datetime.now()
    last_recording_dt = now - timedelta(days=now.weekday() + offset)
    date_suffix = last_recording_dt.strftime('%y%m%d')
    error_code = 1
    for i in range(0, 10):
        url = 'http://www.stokokkino.gr/uploadArchive/{}_19000{}.mp3'.format(
            date_suffix, i)
        logger.info('Downloading %s to %s', url, output_dir)
        try:
            urlretrieve(url, '{}/25-{}.mp3'.format(output_dir,
                                                   date_suffix))
            error_code = 0
            break
        except HTTPError:
            logger.error('%s not accessible', url)
    exit(error_code)

def infowar():
    raise Exception('Under construction')


if __name__ == "__main__":
    main()

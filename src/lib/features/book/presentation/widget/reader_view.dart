import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:bookreading/features/book/presentation/model/reader_paginator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReaderView extends StatefulWidget {
  const ReaderView({super.key, required this.chapters, required this.book});
  final List<ChapterModel> chapters;
  final BookModel book;
  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  final PageController _pageControllers = PageController();
  final ValueNotifier<int> _currentChapterIndex = ValueNotifier(1);
  final ValueNotifier<bool> _areToolsVisible = ValueNotifier(true);

  final ValueNotifier<int> _currentPageIndex = ValueNotifier(1);
  final ReaderPaginator _paginator = ReaderPaginator();
  List<PageData> _pages = [];
  double? _lastSize;
  // bool _areToolsVisible = false;

  void _toggleTools() {
    _areToolsVisible.value = !_areToolsVisible.value;
  }

  @override
  void dispose() {
    _pageControllers.dispose();
    _currentChapterIndex.dispose();
    _areToolsVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisSize: MainAxisSize.min,
      children: [
        _Header(
          book: widget.book,
          currentChapterIndex: _currentChapterIndex,
          areToolsVisible: _areToolsVisible,
        ),
        Positioned(
          top: context.setMinSize(56),
          bottom: context.setMinSize(56),
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _toggleTools(),
            child: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final style = context.bodyLarge().copyWith(
                    fontSize: context.setSp(20),
                    height: 1.4,
                  );
                  final shouldRebuild = _lastSize != constraints.maxHeight;

                  if (shouldRebuild) {
                    _pages = _paginator.buildPages(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      chapters: widget.chapters,
                      style: style,
                    );

                    _lastSize = constraints.maxHeight;
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (mounted) setState(() {});
                    // }
                    // );
                  }

                  return _Content(
                    pages: _pages,
                    onPageChanged: (index) {
                      _currentChapterIndex.value = _pages[index].chapterIndex;
                      _currentPageIndex.value = index + 1;
                    },
                    pageController: _pageControllers,
                    style: style,
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _Footer(
            areToolsVisible: _areToolsVisible,
            currentIndexNotifier: _currentPageIndex,
            pages: _pages,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.book,
    required this.currentChapterIndex,
    required this.areToolsVisible,
  });
  final BookModel book;
  final ValueNotifier<int> currentChapterIndex;
  final ValueNotifier<bool> areToolsVisible;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: areToolsVisible,
      builder: (context, areToolsVisible, _) => SizedBox(
        height: context.setMinSize(56),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IgnorePointer(
                ignoring: !areToolsVisible,
                child: AnimatedOpacity(
                  opacity: areToolsVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () => context.canPop() ? context.pop() : null,
                    color: context.colorTheme.onSurface,
                    icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: currentChapterIndex,
              builder: (context, chapterIndex, child) => Center(
                child: Text(
                  areToolsVisible ? book.author! : "Chapter $chapterIndex ",
                  style: context.bodyMedium().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.pages,

    required this.onPageChanged,
    required this.pageController,
    required this.style,
  });
  final List<PageData> pages;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      itemCount: pages.length,
      onPageChanged: onPageChanged,

      itemBuilder: (context, index) {
        return Text(
          textAlign: TextAlign.start,
          pages[index].text,
          style: style,
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.areToolsVisible,
    required this.currentIndexNotifier,
    required this.pages,
  });

  final ValueNotifier<bool> areToolsVisible;
  final ValueNotifier<int> currentIndexNotifier;
  final List<PageData> pages;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: areToolsVisible,
      builder: (context, visible, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: !visible ? 0 : 1,
          child: IgnorePointer(
            ignoring: !visible,
            child: SizedBox(
              width: context.sizeProvider.width,
              height: context.setMinSize(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: context.sizeProvider.width / 4),
                  Expanded(
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: currentIndexNotifier,
                        builder: (context, index, _) {
                          if (pages.isEmpty || index <= 0) {
                            return const SizedBox.shrink();
                          }

                          final safeIndex = (index - 1).clamp(
                            0,
                            pages.length - 1,
                          );
                          final data = pages[safeIndex];

                          return Text(
                            "${data.pageNumber} / ${pages.length}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
                      ),
                    ),
                  ),
                  // SizedBox(width: context.sizeProvider.width / 4),
                  // context.setMinSize(60)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setMinSize(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorTheme.primary.withOpacity(
                          0.8,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(context.setMinSize(10)),
                      ),
                      child: Icon(
                        Icons.view_list_rounded,
                        size: context.setMinSize(40),
                      ),

                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//  THE object of this volume is to place before the general reader our two early poetic masterpieces — The Canterbury Tales and The Faerie Queen; to do so in a way that will render their “popular perusal” easy in a time of little leisure and unbounded temptations to intellectual languor; and, on the same conditions, to present a liberal and fairly representative selection from the less important and familiar poems of Chaucer and Spenser. There is, it may be said at the outset, peculiar advantage and propriety in placing the two poets side by side in the manner now attempted for the first time. Although two centuries divide them, yet Spenser is the direct and really the immediate successor to the poetical inheritance of Chaucer. Those two hundred years, eventful as they were, produced no poet at all worthy to take up the mantle that fell from Chaucer’s shoulders; and Spenser does not need 
//his affected archaisms, nor his frequent and reverent appeals to “Dan Geffrey,” to vindicate for himself a place very close to his great predecessor in the literary history of England. If Chaucer is the “Well of English undefiled,” Spenser is the broad and stately river that yet holds the tenure of its very life from the fountain far away in other and ruder scenes.

// The Canterbury Tales, so far as they are in verse, have been printed without any 
//abridgement or designed change in the sense. But the two Tales in prose — Chaucer’s Tale of Melibœus, and the Parson’s long Sermon on Penitence — have been contracted, so as to exclude thirty pages of unattractive prose, and to admit the same amount of interesting and characteristic poetry. The gaps thus made in the prose Tales, however, are supplied by careful outlines of the omitted matter, so that the reader need be at no loss to comprehend the whole scope and sequence of the original. With The Faerie Queen a bolder course has been pursued. The great obstacle to the popularity of Spencer’s splendid work has lain less in its language than in its length. If we add together the three great poems of antiquity — the twenty-four books of the Iliad, the twenty-four books of the Odyssey, and the twelve books of the Aeneid — we get at the dimensions of only one-half of The Faerie Queen. The six books, and the fragment of a seventh, which alone exist of the author’s contemplated twelve, number about 35,000 verses; the sixty books of Homer and Virgil number no more than 37,000. The mere bulk of the poem, then, has opposed a formidable barrier to its popularity; to say nothing of the distracting effect produced by the numberless episodes, the tedious narrations, and the constant repetitions, which have largely swelled that bulk. In this volume the poem is compressed into two-thirds of its original space, through the expedient of representing the less interesting and more mechanical passages by a condensed prose outline, in which it has been sought as far as possible to preserve the very words of the poet. While deprecating a too critical judgement on the bare and constrained precis standing in such trying juxtaposition, it is hoped that the labour bestowed in saving the reader the trouble of wading through much that is not essential for the enjoyment of Spencer’s marvellous allegory, will not be unappreciated.

// As regards the manner in which the text of the two great works, especially 
//of The Canterbury Tales, is presented, the Editor is aware that some whose judgement is
// weighty will differ from him. This volume has been prepared “for popular perusal;” and its very raison d’être would have failed, if the ancient orthography had been retained. It has often been affirmed by editors of Chaucer in the old forms of the language, that a little trouble at first would render the antiquated spelling and obsolete inflections a continual source, not of difficulty, but of actual delight, for the reader coming to the study of Chaucer without any preliminary acquaintance with the English of his day — or of his copyists’ days. Despite this complacent assurance, the obvious fact is, that Chaucer in the old forms has not become popular, in the true sense of the word; he is not “understanded of the vulgar.” In this volume, therefore, the text of Chaucer has been presented in nineteenth-century garb. But there has been not the slightest attempt to “modernise” Chaucer, in the wider meaning of the phrase; to replace his words by words which he did not use; or, following the example of some operators, to translate him into English of the modern spirit as well as the modern forms. So far from that, in every case where the old spelling or form seemed essential to metre, to rhyme, or meaning, no change has been attempted. But, wherever its preservation was not essential, the spelling of the monkish transcribers — for the most ardent purist must now despair of getting at the spelling of Chaucer himself — has been discarded for that of the reader’s own day. It is a poor compliment to the Father of English Poetry, to say that by such treatment the bouquet and individuality of his works must be lost. If his masterpiece is valuable for one thing more than any other, it is the vivid distinctness with which English men and women of the fourteenth century are there painted, for the study of all the centuries to follow. But we wantonly balk the artist’s own purpose, and discredit his labour, when we keep before his picture the screen of dust and cobwebs which, for the English people in these days, the crude forms of the infant language have practically become. Shakespeare has not suffered by similar changes; Spencer has not suffered; it would be surprising if Chaucer should suffer, when the loss of popular comprehension and favour in his case are necessarily all the greater for his remoteness from our day. In a much smaller degree — since previous labours in the same direction had left far less to do — the same work has been performed for the spelling of Spenser; and the whole endeavour in this department of the Editor’s task has been, to present a text plain and easily intelligible to the modern reader, without any injustice to the old poet. It would be presumptuous to believe that in every case both ends have been achieved together; but the laudatores temporis acti - the students who may differ most from the plan pursued in this volume — will best appreciate the difficulty of the enterprise,
// and most leniently regard any failure in the details of its accomplishment.

// With all the works of Chaucer, outside The Canterbury Tales, it would have been absolutely 
//impossible to deal within the scope of this volume. But nearly one hundred pages, have been devoted to his minor poems; and, by dint of careful selection and judicious abridgement — a connecting outline of the story in all such cases being given — the Editor ventures to hope that he has presented fair and acceptable specimens of Chaucer’s workmanship in all styles. The preparation of this part of the volume has been a laborious task; no similar attempt on the same scale has been made; and, while here also the truth of the text in matters essential has been in nowise sacrificed to mere ease of perusal, the general reader will find opened up for him a new view of Chaucer and his works. Before a perusal of these hundred pages, will melt away for ever the lingering tradition or prejudice that Chaucer was only, or characteristically, a coarse buffoon, who pandered to a base and licentious appetite by painting and exaggerating the lowest vices of his time. In these selections — made without a thought of taking only what is to the poet’s credit from a wide range of poems in which hardly a word is to his discredit — we behold Chaucer as he was; a courtier, a gallant, pure-hearted gentleman, a scholar, a philosopher, a poet of gay and vivid fancy, playing around themes of chivalric convention, of deep human interest, or broad-sighted satire. In The Canterbury Tales, we see, not Chaucer, but Chaucer’s times and neighbours; the artist has lost himself in his work. To show him honestly and without disguise, as he lived his own life and sung his own songs at the brilliant Court of Edward III, is to do his memory a moral justice far more material than any wrong that can ever come out of spelling. As to the minor poems of Spenser, which follow The Faerie Queen, the choice has been governed by the desire to give at once the most interesting, and the most characteristic of the poet’s several styles; and, save in the case of the Sonnets, the poems so selected are given entire. It is manifest that the endeavours to adapt this volume for popular use, have been already noticed, would imperfectly succeed without the aid of notes and glossary, to explain allusions that have become obsolete, or antiquated words which it was necessary to retain. An endeavour has been made to render each page self- explanatory, by placing on it all the glossarial and illustrative notes required for its elucidation, or — to avoid repetitions that would have occupied space — the references to the spot where information may be found. The great advantage of such a plan to the reader, is the measure of its difficulty for the editor. It permits much more flexibility in the choice of glossarial explanations or equivalents; it saves the distracting and time- consuming reference to the end or the beginning of the book; but, at the same time, it largely enhances the liability to error. The Editor is conscious that in the 12,000 or 13,000 notes, as well as in the innumerable minute points of spelling, accentuation, and rhythm, he must now and again be found tripping; he can only ask any reader who may detect all that he could himself point out as being amiss, to set off against inevitable mistakes and misjudgements, the conscientious labour bestowed on the book, and the broad consideration of its fitness for the object contemplated.

// From books the Editor has derived valuable help; as from Mr Cowden Clarke’s revised modern
// text of The Canterbury Tales, published in Mr Nimmo’s Library Edition of the English Poets;
// from Mr Wright’s scholarly edition of the same work; from the indispensable Tyrwhitt; from
// Mr Bell’s edition of Chaucer’s Poem; from Professor Craik’s “Spenser and his Poetry,” 
//published twenty-five years ago by Charles Knight; and from many others. In the abridgement 
//of the Faerie Queen, the plan may at first sight seem to be modelled on the lines of Mr Craik’s
// painstaking condensation; but the coincidences are either inevitable or involuntary. Many of
// the notes, especially of those explaining classical references and those attached to the minor
// poems of Chaucer, have been prepared specially for this edition. The Editor leaves his task 
//with the hope that his attempt to remove artificial obstacles to the popularity of England’s
// earliest poets, will not altogether miscarry.

// D. LAING PURVES.
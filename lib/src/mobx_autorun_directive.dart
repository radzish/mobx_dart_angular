import 'package:angular/angular.dart';
import 'package:mobx/mobx.dart';

@Directive(selector: '[mobxAutorun]')
class MobxAutorunDirective implements OnInit, OnDestroy {
  final TemplateRef _templateRef;
  final ViewContainerRef _viewContainer;

  Function _disposer;

  @Input()
  dynamic mobxAutorun;

  MobxAutorunDirective(this._templateRef, this._viewContainer);

  @override
  void ngOnInit() {
    final ChangeDetectorRef _view = _viewContainer.createEmbeddedView(_templateRef) as ChangeDetectorRef;

    _dispose();

    _autodetect(_view);
  }

  @override
  void ngOnDestroy() => _dispose();

  void _autodetect(ChangeDetectorRef view) {
    _disposer = autorun((_) => view.detectChanges());
  }

  _dispose() => _disposer?.call();
}

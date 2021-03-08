import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TablaAPIComponentComponent } from './tabla-apicomponent.component';

describe('TablaAPIComponentComponent', () => {
  let component: TablaAPIComponentComponent;
  let fixture: ComponentFixture<TablaAPIComponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TablaAPIComponentComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TablaAPIComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
